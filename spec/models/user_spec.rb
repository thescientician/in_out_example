require 'spec_helper'

describe User do
  it { should belong_to(:team) }
  
  let(:user) { create(:user) }

  describe "#status=" do
    before do
      user.status= status
    end
    
    context "when given an accepted value" do
      let(:status) { :in }
      it "should write the enumerated value in the database" do
        expect(user.send(:read_attribute, :status)).to eql User::STATUSES[status]
      end      
    end
    
    context "when given an unaccepted value" do
      let(:status) { :bad_status }
      it "should write nil in the database" do
        expect(user.send(:read_attribute, :status)).to be_nil
      end      
      
    end
  end

  shared_examples_for "ip" do |model, method_name|

    let(:mutator_method_name) {"#{method_name}="}

    it "should be accessible" do
      model.should respond_to(method_name)
    end

    it "should be mutatable" do
      model.should respond_to("#{method_name.to_s}=")
    end

    it "should respond with 127.0.0.1 if known value" do
      model.stub(:read_attribute).with(method_name).and_return(2130706433)
      model.send(method_name).should eq("127.0.0.1")
    end

    it "should respond with 127.0.0.1 if known value" do
      model.stub(:read_attribute).with(method_name).and_return(-1)
      model.send(method_name).should eq("255.255.255.255")
    end

    it "should write attribute" do
      model.should_receive(:write_attribute).with(method_name, 1)
      model.send("#{method_name}=", "0.0.0.1")
    end

  end

  describe "last_sign_in_ip" do
    it_should_behave_like "ip", User.new, :current_sign_in_ip
  end

  describe "last_sign_in_ip" do
    it_should_behave_like "ip", User.new, :last_sign_in_ip 
  end
  
end
