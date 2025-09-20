require "tempfile"

class ChatController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    prompt = "Reply in English: #{params[:prompt]}"
    generate_image = ActiveModel::Type::Boolean.new.cast(params[:generate_image])
    ai_reply = get_ai_reply(prompt)
  
    appearance = params[:character_appearance] || "Telugu actress in saree"
    image_prompt = appearance.downcase.gsub(/[^a-z\s]/, '').split.first(3).join(',')
    image_url = generate_image ? "https://source.unsplash.com/800x500/?#{URI.encode_www_form_component(image_prompt)}" : nil
byebug
    render json: {
      reply: ai_reply,
      image_url: image_url,
      voice_url: generate_voice_url(ai_reply)
    }
  end    

  def voice
    text = params[:text]
    file = generate_voice_file(text)
  
    if File.exist?(file.path) && File.size(file.path) > 0
      audio_data = File.binread(file.path)
  
      send_data audio_data,
                type: "audio/mpeg",
                disposition: "inline",
                filename: "voice.mp3",
                status: :ok
  
      file.close
      file.unlink
    else
      render plain: "Voice file not generated", status: :internal_server_error
    end
  end  

  private

  def get_ai_reply(prompt)
    uri = URI("http://localhost:11434/api/generate")
    body = { model: "openchat", prompt: prompt, stream: false }.to_json
    headers = { "Content-Type" => "application/json" }

    response = Net::HTTP.post(uri, body, headers)
    JSON.parse(response.body)["response"]
  end

  def generate_voice_file(text)
    file = Tempfile.new(["voice", ".mp3"])
    voice = "en-IN-NeerjaNeural"
  
    puts "Generating voice for: #{text}"
    success = system("edge-tts --text \"#{text}\" --voice #{voice} --write-media \"#{file.path}\"")
    puts "Voice generated: #{file.path}, Success: #{success}, Exists: #{File.exist?(file.path)}, Size: #{File.size(file.path)}"
  
    file
  end
  
  def generate_voice_url(text)
    timestamp = Time.now.to_i
    "/chat/voice?text=#{URI.encode_www_form_component(text)}&t=#{timestamp}"
  end
end
