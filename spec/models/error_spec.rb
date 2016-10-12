require 'spec_helper'

module PivotalMarkdown
  module CLI
    describe Error do

      it 'returns errors' do
        Error.methods(false).each do |method|
          object = Error.send method
          expect(object).to be_a StandardError
        end
      end

    end
  end
end
