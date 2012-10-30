# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'active_model'

class Validatable
  include ActiveModel::Validations
  validates_word_count :text, {:min => 5, :max => 7}
end

describe ActiveModel::Validations::WordCountValidator do
  subject { Validatable.new }

  context 'with a text of correct length' do
    before { subject.stub(:text).and_return 'word '*5 }
    it { should be_valid }
  end

  context 'with a text of incorrect length' do
    before { subject.stub(:text).and_return 'word'*8 }
    it { should_not be_valid }
  end

  context 'with a unicode text of correct length' do
    before { subject.stub(:text).and_return 'Шла Саша по шосса и сосала сушку' }
    it { should be_valid }
  end

  context 'with a unicode text of incorrect length' do
    before { subject.stub(:text).and_return 'Шла Саша на хуй' }
    it { should_not be_valid }
  end
end
