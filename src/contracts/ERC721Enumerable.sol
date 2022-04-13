// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {
    uint256[] private _allTokens;

    // mapping from tokenId to position in _allTokens arrays
    mapping(uint256 => uint256) private _tokenIdToIndex;

    // mapping of owner to list of all owner token id
    mapping(address => uint256[]) private _ownerToTokens;

    // mapping from tokenId index of the owner token lists
    mapping(address => uint256[]) private _ownerToTokenIndex;

    /// @notice Count NFTs tracked by this contract
    /// @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    function totalSupply() external view returns (uint256) {
        return _allTokens.length;
    }

    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        // Things to consider to keep record of all the tokens during minting 
        // A. add tokens to the owner
        // B. all the tokens to our totalsupply - to allTokens
        _addTokensToTotalSupply(tokenId);
    }

    function _addTokensToTotalSupply(uint256 tokenId) private {
      _allTokens.push(tokenId);

    }
}
