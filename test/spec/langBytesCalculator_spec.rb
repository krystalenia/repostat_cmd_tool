require 'repostats/modules/calculations/math_module.rb'
require 'repostats/calculations/language_bytes.rb'
require 'active_support/all'


describe LanguageBytesCalculator do

  #Setup
  before(:each) do
    @data = {:main_languages => ['Ruby', 'Java', 'Ruby'],
             :languages => ['Ruby', 'HTML', 'CSS', 'Java', 'Makefile', 'JavaScript'],
             :languages_bytes => JSON.parse('[{"Ruby":20,"HTML":10,"CSS":30},{"Java":60,"Makefile":10},{"Ruby":20,"HTML":10,"JavaScript":50}]'),
             :total_bytes => 200,
             :total_repos_lang => 8
    }
    @languageBytesCalc = LanguageBytesCalculator.new
  end


  describe '#bytes_per_lang_toArr' do

    let(:result) {{"Ruby" => 40, "HTML" => 20, "CSS" => 30, "Java" => 60, "Makefile" => 10, "JavaScript" => 50}}
    let(:result2) {{"Ruby" => 0, "HTML" => 0, "CSS" => 0, "Java" => 0, "Makefile" => 0, "JavaScript" => 0}}


    context 'calculates the total amount of bytes per language' do

      context 'given languages and repositories ' do
        it 'returns bytes per specific language' do

          expect(@languageBytesCalc.bytes_per_lang_toArr(@data[:languages], @data[:languages_bytes])).to eql(result)

        end
      end

      context 'given languages but no repositories ' do
        it 'returns bytes per specific language' do

          expect(@languageBytesCalc.bytes_per_lang_toArr(@data[:languages], [])).to eql(result2)

        end
      end

    end
  end

  describe '#lang_freq_toHash' do

    let(:result) {{"Ruby" => 2, "HTML" => 2, "CSS" => 1, "Java" => 1, "Makefile" => 1, "JavaScript" => 1}}

    it 'computes the frequency for each language' do

      expect(@languageBytesCalc.lang_freq_toHash(@data[:languages], @data[:languages_bytes])).to eql(result)

    end
  end

  describe '#lang_bytes_percentage_toHash' do

    let(:result) {{"Ruby" => 20.0, "HTML" => 10.0, "CSS" => 15.0, "Java" => 30.0, "Makefile" => 5.0, "JavaScript" => 25.0}}

    it 'calculates the language bytes percentage' do

      expect(@languageBytesCalc.lang_bytes_percentage_toHash(@data[:languages], @data[:languages_bytes], @data[:total_bytes])).to eql(result)

    end
  end


  describe '#avg_langBytes_per_repo_toHash' do

    let(:result) {{"Ruby" => 13.33, "HTML" => 6.67, "CSS" => 10.0, "Java" => 20.0, "Makefile" => 3.33, "JavaScript" => 16.67}}


    it 'calculates the average language bytes per num of repositories' do

      expect(@languageBytesCalc.avg_langBytes_per_repo_toHash(@data[:main_languages], @data[:languages], @data[:languages_bytes])).to eql(result)

    end
  end


  describe '#avg_langBytes_per_lang_toHash' do

    let(:result) {{"Ruby" => 6.67, "HTML" => 3.33, "CSS" => 5.0, "Java" => 10.0, "Makefile" => 1.67, "JavaScript" => 8.33}}

    it 'calculates the average language bytes per num of languages' do

      expect(@languageBytesCalc.avg_langBytes_per_lang_toHash(@data[:languages], @data[:languages_bytes])).to eql(result)

    end
  end

  describe '#langUsages_percent_toHash' do

    let(:result) {{"Ruby" => 25.0, "HTML" => 25.0, "CSS" => 12.5, "Java" => 12.5, "Makefile" => 12.5, "JavaScript" => 12.5}}
    it 'calculates the languages usages per number of language' do

      expect(@languageBytesCalc.langUsages_percent_toHash(@data[:languages], @data[:languages_bytes], @data[:total_repos_lang])).to eql(result)

    end
  end

  describe '#mainlang_usages_percent_toHash' do

    let(:result) {{"Ruby" => 66.67, "Java" => 33.33}}


    it 'calculates the frequency of the languages used as main across all repos' do

      expect(@languageBytesCalc.mainlang_usages_percent_toHash(@data[:main_languages])).to eql(result)

    end
  end


end