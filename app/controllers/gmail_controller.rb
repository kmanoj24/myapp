require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/web_user_authorizer'
require 'time'

class GmailController < ApplicationController
    def callback
        client_id = Google::Auth::ClientId.new(ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'])
      
        client = Signet::OAuth2::Client.new(
          client_id: client_id.id,
          client_secret: client_id.secret,
          token_credential_uri: 'https://oauth2.googleapis.com/token',
          redirect_uri: 'http://localhost:3000/callback',
          code: params[:code]
        )
        client.fetch_access_token!
      
        session[:access_token] = client.access_token
        redirect_to '/recent_emails'
    end  

    def auth
        client_id = Google::Auth::ClientId.new(ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'])
    
        client = Signet::OAuth2::Client.new(
        client_id: client_id.id,
        client_secret: client_id.secret,
        authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
        scope: 'https://www.googleapis.com/auth/gmail.readonly',
        redirect_uri: 'http://localhost:3000/callback',
        access_type: 'offline',
        prompt: 'consent'
        )
    
        redirect_to client.authorization_uri.to_s, allow_other_host: true
    end

    def recent_emails
        return render plain: "No access token. Please sign in first." unless session[:access_token]
      
        service = Google::Apis::GmailV1::GmailService.new
        client = Signet::OAuth2::Client.new(
          access_token: session[:access_token]
        )
        service.authorization = client
      
        one_hour_ago = (Time.now - 1.hour).to_i
        result = service.list_user_messages('me', q: "after:#{one_hour_ago}")
      
        messages = result.messages&.map do |msg_ref|
          msg = service.get_user_message('me', msg_ref.id)
          {
            subject: msg.payload.headers.find { |h| h.name == 'Subject' }&.value,
            from:    msg.payload.headers.find { |h| h.name == 'From' }&.value,
            snippet: msg.snippet
          }
        end
      
        render json: messages
    end      
end
