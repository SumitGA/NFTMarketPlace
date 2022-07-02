const {assert} = require('chai');
const KryptoBird = artifacts.require('./KryptoBird.sol');

//check for chai
require('chai').use(require('chai-as-promised')).should();


// eslint-disable-next-line no-undef
contract('KryptoBird', (accounts) => {
  let contract;

  // testing container - describe
  describe('deployment', async () => {
    // test samples with writing it
    it('deploys successfully', async () => { 
      contract = await KryptoBird.deployed();
      const address = contract.address;
      assert.notEqual(address, '');
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
      assert.notEqual(address, 0x0);
    })

    it('has a name', async() => {
      const name = await contract.name();
      assert.equal(name, 'KryptoBird');
    })

    it('has a symbol', async() => {
      const symbol = await contract.symbol();
      assert.equal(symbol, 'KBIRDZ');
    })
  })
})
