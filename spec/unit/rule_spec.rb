require 'spec_helper'

module SimpleActivity
  describe Rule do
    context "#get_rules" do
      it "returns valid rules" do
        rules = {'Article'=> {
          'create'=>'bar',
          '_cache'=>'foo'}}
        allow(Rule).to receive(:all_rules).and_return(rules)
        output = Rule.get_rules('Article', '_cache')
        expect(output).to eq('foo') 
      end

      it "returns nil when specific rule undefined" do
        rules = {'Article'=> {'create'=>'bar'} }
        allow(Rule).to receive(:all_rules).and_return(rules)
        output = Rule.get_rules('Article', '_cache')
        expect(output).to be_nil
      end
    end
  end
end
