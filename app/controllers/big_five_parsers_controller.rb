class BigFiveParsersController < ApplicationController
  def index
    @big_file_result = BigFiveResult.new
  end

  def parse_result
    @big_file_result = BigFiveResult.new big_five_result_params
    @big_file_result.result = BigFiveParser::Parser.new(@big_file_result.file.path, @big_file_result.name, @big_file_result.email).parse
    @result = JSON.parse(@big_file_result.result)
  end

  def submit_to_recruitbot
    @response = BigFiveParser::Submitter.submit_to_recruitbot(params[:result])
  end

  private

  def big_five_result_params
    params.require(:big_five_result).permit(:file, :name, :email)
  end
end
