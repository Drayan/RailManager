class ApplicationController < ActionController::Base
    def index
    end

    def turbo_visit(url, frame: nil, action: nil)
        options = {frame: frame, action: action}.compact
        turbo_stream.append_all("head") do
            helpers.javascript_tag(<<~SCRIPT.strip, nonce: true, data: {turbo_cache: false})
            window.Turbo.visit("#{helpers.escape_javascript(url)}", #{options.to_json})
            document.currentScript.remove()
            SCRIPT
        end
    end
end
