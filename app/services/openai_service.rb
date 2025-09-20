require 'httparty'

class OpenaiService
  include HTTParty
  base_uri 'https://api.openai.com/v1'

  def initialize
    @headers = {
      "Authorization" => "Bearer #{ENV['OPENAI_API_KEY']}",
      "Content-Type" => "application/json"
    }
  end

  def check_available_models
    response = self.class.get("/models", headers: @headers)

    if response.code != 200
      return "Error: #{response.code} - #{response.body}"
    end

    json = JSON.parse(response.body)
    model_names = json['data'].map { |model| model['id'] }
    
    model_names
  end

  def chat(user_message)
    character_name = Rails.cache.read('character_name') || 'Unknown Character'
    character_situation = Rails.cache.read('character_situation') || 'No situation set.'

    prompt = "You are a character named #{character_name}, who is currently in the situation: #{character_situation}. Respond to the following message: #{user_message}"

    response = self.class.post("/completions", 
      headers: @headers,
      body: {
        model: "gpt-4",  # Or another model depending on availability
        messages: [{ role: "user", content: prompt }]
      }.to_json
    )
    
    if response.code != 200
      return "Error: #{response.code} - #{response.body}"
    end

    json = JSON.parse(response.body)
    json.dig("choices", 0, "message", "content") || "Error processing request"
  end
end
