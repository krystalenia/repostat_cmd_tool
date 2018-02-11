require 'active_support/all'
require 'repostats/modules/calculations/math_module.rb'
require 'repostats/validations/validations.rb'
require 'repostats/modules/organization.rb'
require 'repostats/parser/parse_data.rb'

describe ParseData do

	 before(:each) do

    @data =  {:org => "skroutz",
    		  :search_org_response => {"total_count": 1,"incomplete_results": false,"items": [{"login": "skroutz","id": 285550,}]}, 
    		  :search_org_empty_resp => '{"total_count": 0,"incomplete_results": false,"items": []}',
    		  :search_org_response_3 => {"total_count": 3,"incomplete_results": false,"items": [{"login": "skrout","id": 285550},{"login": "skrot","id": 2855501},{"login": "skroutz","id": 2855502}]},
    		  :search_org_response_11 => {"total_count": 11,"incomplete_results": false,"items": [{"login": "skroutz","id": 285550,}]}
   		 	 }

   		 	    	@parseData = ParseData.new

  end

describe "#parse_org_response" do

	 let(:result1) {true}
	 let(:result2) {"Organization found does not match with the input one"}
	 let(:result3) {"Organization was not found"}
	 let(:result4) {"Related Organizations: skrout, skrot, skroutz"}
 	 let(:result5) {"More than 10 organizations found"}


	context 'Parses the response from Search organization API' do
 		
 		context 'when 1 organization matches the query and is the requested one' do
 			it 'returns true' do

				expect(@parseData.parse_org_response(@data[:org], @data[:search_org_response].to_json)).to eql(result1)

			end
 		end

 		context 'when 1 organization matches the query and is not the requested one' do
 			it 'returns info message' do

				expect(@parseData.parse_org_response("skrout", @data[:search_org_response].to_json)).to eql(result2)

			end
 		end

 		context 'when no organization matches the query' do
 			it 'returns info message' do
 				expect(@parseData.parse_org_response(@data[:org], @data[:search_org_empty_resp].to_json)).to eql(result3)

 			end
 		end

 		context 'when less than 10 organizations matches the query' do
 			it 'returns info message' do
 				expect(@parseData.parse_org_response(@data[:org], @data[:search_org_response_3].to_json)).to eql(result4)

 			end
 		end

 		context 'when more than 10 organizations matches the query' do
 			it 'returns info message' do
 				expect(@parseData.parse_org_response(@data[:org], @data[:search_org_response_11].to_json)).to eql(result5)

 			end
 		end
 	end
 end

end