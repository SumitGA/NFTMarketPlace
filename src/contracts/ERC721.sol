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

  event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

  // mapping in solidity creates a hash table of key value pairs
  // mapping from token id to token owner
  mapping(uint256  => address) private _tokenOwner;

  // mapping from owner to number of owned tokens
  mapping(address => uint256) private _OwnedTokensCount;

  // @notice Count all NTFs assigned to an owner
  /// @dev NFTs assigned to the zero address are cosidered invalid, and this is 
  // function throws for queries about the zero address.
  /// @param _owner An address for whom to query the balance
  /// @return The number of NFTs owned by _owner, possibly zero
  function balanceOf(address _owner) external view returns(uint256) {
    require(_owner != address(0), 'Owner query cannot be for the zero address');
    return _OwnedTokensCount[_owner];
  }

  // @notice Find the owner of an NFT
  // @dev NFTs assigned to zero address are considered invalid, and queries
  // about them do throw.
  /// @param _tokenId The identifier for the NFT
  /// @return The address of the owner of the NFT
  function ownerOf(uint256 _tokenId) external view returns(address) {
    require(_tokenId != 0, 'Token ID cannot be zero');
    return _tokenOwner[_tokenId];
  }

  function _exists(uint256 tokenId) internal view returns (bool){
    // checking truthyness that the token id exists
    return  _tokenOwner[tokenId] != address(0);
  }

  function _mint(address to, uint256 tokenId) internal{
    // requires that the address is not zero
    require(to != address(0), 'ERC721: minting to the zero address');

    // requires that the token does not alreayd exist
    require(_exists(tokenId) != true, 'ERC721: minting a token that already exists');

    // adding a new address with token id for minting
    _tokenOwner[tokenId] == to;
    _OwnedTokensCount[to] += 1;

    emit Transfer(address(0), to, tokenId);
  }
}