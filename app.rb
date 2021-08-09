#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'sinatra'

COMPANY_IDEAS = File.read('company-ideas.txt').split("\n").map(&:strip)
OPEN_SOURCE_IDEAS = File.read('open-source-ideas.txt').split("\n").map(&:strip)

def html(idea, open_source: false)
  idea = idea.gsub(/\[[^\]]+\] /, '')
  <<~HTML
    <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8" />
        <title>This Idea Does Not Exist</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
        html, body, .container {
          font-family: 'Courier New', monospace;
        }

        .container {
          text-align: center;
          margin-top: 20px;
        }

        .container h2 {
          margin: 30px auto;
          text-align: center;
          width: 80%;
        }

        .footer {
          position: fixed;
          bottom: 10px;
          width: 100%;
        }
        </style>
      </head>
      <body>
        <div class="container">
          <span>This Idea Does Not Exist | </span>
          <span>[#{open_source ? "<a href='/'>companies</a>" : "companies"}]</span>
          <span>[#{open_source ? "open source projects" : "<a href='/open-source'>open source projects</a>"}]</span>
          <h2>
            #{idea}
          </h2>

          <div class="footer">
            <a href='#{open_source ? '/open-source' : '/'}'>next</a>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            ideas not thought up by <a href='https://twitter.com/tectonic'>@tectonic</a>
          </div>
        </div>
      </body>
    </html>
  HTML
end

get '/' do
  idea = COMPANY_IDEAS[(COMPANY_IDEAS.length * rand).floor]
  html idea, open_source: false
end

get '/open-source' do
  idea = OPEN_SOURCE_IDEAS[(OPEN_SOURCE_IDEAS.length * rand).floor]
  html idea, open_source: true
end
