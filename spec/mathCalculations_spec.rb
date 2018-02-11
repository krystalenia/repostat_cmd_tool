require 'repostats/modules/calculations/math_module.rb'
require 'active_support/all'


describe MathModule do

  before(:each) do

    @data =  {:main_languages => ['Ruby', 'Java','Ruby'],
    		  :languages => ['Ruby', 'HTML', 'CSS', 'Java', 'Makefile', 'JavaScript'],
    		  :languages_bytes => JSON.parse('[{"Ruby":20,"HTML":10,"CSS":30},{"Java":60,"Makefile":10},{"Ruby":20,"HTML":10,"JavaScript":50}]'),
    	      :total_bytes => 200,
    	  	  :total_repos_lang => 8
   		 	 }
  end

describe '#sum_repo_bytes' do

	 let(:result1) {60}
	 let(:result2) {70}
	 let(:result3) {0}

 	context 'sums the bytes of a given repository when' do

 		context 'repository hash is not empty' do
 			it 'returns the repository size' do

				expect(MathModule.sum_repo_bytes(@data[:languages_bytes][0])).to eql(result1)
				expect(MathModule.sum_repo_bytes(@data[:languages_bytes][1])).to eql(result2)

			end
 		end

 		context 'repository hash is empty' do
 			it 'returns zero value for size' do
 				expect(MathModule.sum_repo_bytes({})).to eql(result3)

 			end
 		end
 	end

end


describe '#count_items' do

	 let(:result1) {2}
	 let(:result2) {3}
	 let(:error_msg)   {"MathModule => Array should not be empty"}

	 context 'counts the length of a given array when' do

 		context 'array is not empty' do
 			it 'returns array size' do

				expect(MathModule.count_items(@data[:languages_bytes][1])).to eql(result1)
				expect(MathModule.count_items(@data[:languages_bytes])).to eql(result2)

			end
 		end

 		context 'array is empty' do
 			it 'raises an error' do
 				expect{MathModule.count_items([])}.to raise_error(error_msg)
 			end
 		end
 	end
end


describe '#total_repos_bytes' do

	 let(:result1) {210}
	 let(:result2) {150}
	 let(:result3) {0}


	 context 'calculates the total bytes of all repos when' do

 		context 'repos do exist' do
 			it 'returns total repos bytes' do

				expect(MathModule.total_repos_bytes(@data[:languages_bytes])).to eql(result1)
				expect(MathModule.total_repos_bytes(@data[:languages_bytes][1..2])).to eql(result2)

			end
 		end

 		context 'no repo exists' do
 			it 'returns zero' do
 				expect(MathModule.total_repos_bytes([])).to eql(result3)
 			end
 		end
 	end
end

describe '#sum_lang_bytes' do

	 let(:result1) {40}
	 let(:result2) {60}

	 context 'Sums the code bytes written for a specific language ' do

 		context 'given repos and lang' do
 			it 'returns total bytes for specific language' do

				expect(MathModule.sum_lang_bytes(@data[:languages_bytes], "Ruby")).to eql(result1)
				expect(MathModule.sum_lang_bytes(@data[:languages_bytes][1..2], "Java")).to eql(result2)

			end
 		end

 		context 'no repo given' do
 			it 'returns zero' do
 				expect(MathModule.sum_lang_bytes([], "Java")).to eql(0)
 			end
 		end

 		context 'no lang given' do
 			it 'returns zero' do
 				expect(MathModule.sum_lang_bytes(@data[:languages_bytes], "")).to eql(0)
 			end
 		end
 	end
end


describe '#calc_lang_freq' do

	 let(:result1) {2}
	 let(:result2) {0}

	 	context 'Counts the amount of times a language has been used across all repos' do

 		context 'given repos and lang' do
 			it 'returns a frequency for a specific language' do

				expect(MathModule.calc_lang_freq(@data[:languages_bytes], "Ruby")).to eql(result1)
				expect(MathModule.calc_lang_freq(@data[:languages_bytes], "Cobol")).to eql(result2)

			end
 		end

 		context 'no repo given' do
 			it 'returns zero' do
 				expect(MathModule.calc_lang_freq([], "Java")).to eql(0)
 			end
 		end

 		context 'no lang given' do
 			it 'returns zero' do
 				expect(MathModule.calc_lang_freq(@data[:languages_bytes], " ")).to eql(0)
 			end
 		end
 	end
end

describe '#calc_main_lang_freq' do

	 let(:result1) {2}
	 let(:result2) {0}

	 	context 'Calculates the times the same language has been used as main across all repos' do

 		context 'given all languages and a specific lang' do
 			it 'returns a frequency for a specific language' do

				expect(MathModule.calc_main_lang_freq(@data[:main_languages], "Ruby")).to eql(result1)
				expect(MathModule.calc_main_lang_freq(@data[:main_languages], "Cobol")).to eql(result2)

			end
 		end

 		context 'no languages given' do
 			it 'returns zero' do
 				expect(MathModule.calc_main_lang_freq([], "Java")).to eql(0)
 			end
 		end

 		context 'no specific lang given' do
 			it 'returns zero' do
 				expect(MathModule.calc_main_lang_freq(@data[:main_languages], nil)).to eql(0)
 			end
 		end
 	end
end


describe '#division' do

	 let(:result1) {0.25}
	 let(:result2) {-0.5}
	 let(:error)   {"MathModule => Division error: perhaps value_B is zero"}

	 context 'Division between two integer values' do

 		context 'given two non zero values' do
 			it 'returns the division result' do

				expect(MathModule.division(1, 4)).to eql(result1)
				expect(MathModule.division(-1, 2)).to eql(result2)

			end
 		end

 		context 'given 0 as a first argument ' do
 			it 'returns zero' do
 				expect(MathModule.division(0, 1)).to eql(0.0)
 			end
 		end

 		context 'given 0 as a second argument ' do
 			it 'returns zero' do
 				expect{MathModule.division(1, 0)}.to raise_error(error)
 			end
 		end


 	end
end


describe '#calc_percentance' do

	 context 'Calculates the percentage of a value' do

 		context 'given one positive value' do
 			it 'returns the percentage' do

				expect(MathModule.calc_percentance(0.4)).to eql(40.0)
				expect(MathModule.calc_percentance(0.452)).to eql(45.2)


			end
 		end

 		context 'given one negative value' do
 			it 'returns zero' do
 				expect(MathModule.calc_percentance(-0.3)).to eql(nil)
 			end
 		end

 		context 'given 0 as an argument ' do
 			it 'returns zero' do
 				expect(MathModule.calc_percentance(0)).to eql(0.0)
 			end
 		end


 	end
end


describe '#create_set' do

	let(:result) {["Ruby", "Java"]}

	 context 'Create set from an array' do

 		context 'given one array of values' do
 			it 'returns the created set' do

				expect(MathModule.create_set(@data[:main_languages])).to eql(result)

			end
 		end

 		context 'given an empty array' do
 			it 'returns empty set' do
 				expect(MathModule.create_set([])).to eql([])
 			end
 		end

 	end
end

end
