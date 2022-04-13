// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721.sol";

contract ERC721Enumerable is ERC721 {
    uint256[] private _allTokens;

    // mapping from tokenId to position in _allTokens arrays
    mapping(uint256 => uint256) private _allTokensIndex;

    // mapping of owner to list of all owner token id
    mapping(address => uint256[]) private _ownedTokens;

    // mapping from tokenId index of the owner token lists
    mapping(uint256 => uint256) private _ownedTokensIndex;

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
        _addTokensToAllTokensEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    function _addTokensToAllTokensEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    // add tokens to the _allTokens array and set the
    // position of the tokenIndexes
    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        // 1. add address and token id to the _ownedTokens
        // 2. ownedTokensIndex tokenId set to address of ownedTokens position
        // 3. we want to execute this function with minting
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    function tokenByIndex(uint256 index) public view returns (uint256) {
        // check for index out of bounds for total supply
        require(index < this.totalSupply(), "global index out of bounds!");
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint256 index)
        public
        view
        returns (uint256)
    {

      require(index < this.balanceOf(owner), 'owner index is out of bounds');
        return _ownedTokens[owner][index];
    }
}
