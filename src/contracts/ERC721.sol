// SPDX-License-Identifieer: MIT
pragma solidity ^0.8.0;

import './ERC721Metadata.sol';

  /**
  bulding out the minting function
    a. nft to point to an address
    b. keep track of the token ids
    c. keep tack of token owners address to token id
    d. keep track of how many tokens an owner address has
    e. emit an event when a token is transfered - contract address, where it is transfered from, to, token id
   */

contract ERC721 {
  // mapping in solidity creates a hash table of key value pairs
  // mapping from token id to token owner
  mapping(uint256  => address) private _tokenOwner;

  // mapping from owner to number of owned tokens
  mapping(address => uint256) private _OwnedTokensCount;

  function _exists(uint256 tokenId) internal view returns (bool){
    // checking truthyness that the token id exists
    return  _tokenOwner[tokenId] != address(0);
  }

  function _mint(address to, uint256 tokenId) internal{
    require(to != address(0), 'ERC721: minting to the zero address');
    require(_exists(tokenId) != true, 'ERC721: minting a token that already exists');
    _tokenOwner[tokenId] == to;
    _OwnedTokensCount[to] += 1;
  }
}