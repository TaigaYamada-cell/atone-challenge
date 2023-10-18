class RescueJsonParseErrors
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue ActionDispatch::ParamsParser::ParseError => _e
      return [
        400, { 'Content-Type' => 'application/json' },
        [{ error: {code: 400, message: 'There was a problem in the your JSON' }}.to_json]
      ]
    end
  end
end