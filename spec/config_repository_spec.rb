require 'spec_helper'

module PageConfigurator
  describe ConfigRepository do
    before do
      ConfigRepository.initialize
    end

    it 'allows storing data' do
      ConfigRepository.store('foo', 'some data')

      expect(ConfigRepository.all).to eq({ 'foo' => 'some data' })
    end

    it 'allows getting data' do
      ConfigRepository.store('foo', 'some data')

      expect(ConfigRepository.search('foo')).to eq('some data')
    end

    it 'allows removing data' do
      ConfigRepository.store('foo', 'some data')
      ConfigRepository.remove('foo')

      expect(ConfigRepository.all).to eq({})
    end
  end
end
