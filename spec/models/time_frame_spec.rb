require 'spec_helper'

describe TimeFrame do
  context 'class methods' do
    it 'can find a time frame by input' do
      TimeFrame.should respond_to(:find_by_input)
    end
  end
end
