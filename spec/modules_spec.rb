require 'logger'
require 'repostats/modules/modules.rb'


describe UnescapeEncoder do

	 let(:result1) {"type=sources"}
	 let(:result2) {"testParam=@test"}
	 let(:result3) {"type=noSpecialChar"}

	context 'encodes parameters for api call' do

 		context 'when parameter includes special character' do
 			it 'returns the parameter value without encoding' do

				expect(UnescapeEncoder.encode({:type => "sources"})).to eql(result1)
				expect(UnescapeEncoder.encode({:testParam => "@test"})).to eql(result2)

			end
 		end

 		context 'when parameter does not include special character' do
 			it 'returns parameter value' do
 				expect(UnescapeEncoder.encode({:type => "noSpecialChar"})).to eql(result3)

 			end
 		end
 	end

end