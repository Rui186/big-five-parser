require 'rails_helper'

RSpec.describe BigFiveParsersController, type: :controller do
  render_views

  describe '#index' do
    it 'should render' do
      get :index
      expect(response).to be_successful
      expect(assigns(:big_file_result)).to be_present
    end
  end

  describe '#parse_result' do
    it 'should render' do
      file = fixture_file_upload(Rails.root.join('spec', 'test.txt'), 'txt')
      name = 'name'
      email = 'test@test.com'
      parser = double('BigFiveParser::Parser')
      parse_result = double('BigFiveParser::Parser')
      result = { 'NAME': 'name' }
      file_path = 'spec/test.txt'
      expect_any_instance_of(File).to receive(:path).at_least(:once).and_return(file_path)
      expect(BigFiveParser::Parser).to receive(:new).with(file_path, name, email).and_return(parser)
      expect(parser).to receive(:parse).and_return(parse_result)
      expect(JSON).to receive(:parse).with(parse_result).and_return(result)
      post :parse_result, params: { big_five_result: { file: file, name: name, email: email } }, xhr: true
      expect(response).to be_successful
      expect(assigns(:big_file_result).name).to eq name
      expect(assigns(:big_file_result).email).to eq email
      expect(assigns(:big_file_result).result).to eq parse_result
      expect(assigns(:result)).to eq result
    end
  end

  describe '#submit_to_recruitbot' do
    it 'should render' do
      result = double('JSON')
      response = { status: 201, token: 'token' }
      expect(BigFiveParser::Submitter).to receive(:submit_to_recruitbot).with(result.to_s).and_return(response)
      post :submit_to_recruitbot, params: { result: result }, xhr: true
      expect(assigns(:response)).to eq response
    end
  end
end
