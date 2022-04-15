// SPDX-License-Identifieer: MIT
pragma solidity ^0.8.0;

import "./ERC165.sol";
import "./interfaces/IERC721.sol";

/**
  bulding out the minting function
    a. nft to point to an address
    b. keep track of the token ids
    c. keep tack of token owners address to token id
    d. keep track of how many tokens an owner address has
    e. emit an event when a token is transfered - contract address, where it is transfered from, to, token id
   */

// Implementing ERC165 interface for compilance issues with ERC721
contract ERC721 is ERC165, IERC721 {
    // mapping in solidity creates a hash table of key value pairs
    // mapping from token id to token owner
    mapping(uint256 => address) private _tokenOwner;

    // mapping from owner to number of owned tokens
    mapping(address => uint256) private _OwnedTokensCount;

    // mapping from token id to approved addresses
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    // @notice Count all NTFs assigned to an owner
    /// @dev NFTs assigned to the zero address are cosidered invalid, and this is
    // function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by _owner, possibly zero
    function balanceOf(address _owner) public override view returns (uint256) {
        require(
            _owner != address(0),
            "Owner query cannot be for the zero address"
        );
        return _OwnedTokensCount[_owner];
    }

    // @notice Find the owner of an NFT
    // @dev NFTs assigned to zero address are considered invalid, and queries
    // about them do throw.
    /// @param _tokenId The identifier for the NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) public override view returns (address) {
        require(_tokenId != 0, "Token ID cannot be zero");
        return _tokenOwner[_tokenId];
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        // checking truthyness that the token id exists
        return _tokenOwner[tokenId] != address(0);
    }

    function _mint(address to, uint256 tokenId) internal virtual {
        // requires that the address is not zero
        require(to != address(0), "ERC721: minting to the zero address");

        // requires that the token does not alreayd exist
        require(
            _exists(tokenId) != true,
            "ERC721: minting a token that already exists"
        );

        // adding a new address with token id for minting
        _tokenOwner[tokenId] == to;
        _OwnedTokensCount[to] += 1;

        emit Transfer(address(0), to, tokenId);
    }

    function _transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) internal {
        require(
            _to != address(0),
            "Error - ERC721: transfer to the zero address"
        );
        require(
            ownerOf(_tokenId) == _from,
            "Trying to transfer a token the address does not owned"
        );

        _OwnedTokensCount[_from] -= 1;
        _OwnedTokensCount[_to] += 1;
        _tokenOwner[_tokenId] == _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) public override {
        require(
            isApprovedOrOwner(msg.sender, _tokenId),
            "ERC721: must have approved or owner status for the token"
        );
        _transferFrom(_from, _to, _tokenId);
    }

    // 1. require that the person approving is the owner
    // 2. we are approving an address to a token (tokenId)
    // 3. require that we cant approve sending tokens of owner to the owner
    // 4. update the mapping of the approval addresses
    function approve(address _to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(_to != owner, "Error - approval to current owner");
        require(
            msg.sender == owner,
            "Current caller is not the owner of the token"
        );
        _tokenApprovals[tokenId] == _to;

        emit Approval(owner, _to, tokenId);
    }

    function isApprovedForAll(address owner, address operator)
        public
        view
        returns (bool)
    {
        return _operatorApprovals[owner][operator];
    }

    function getApproved(uint256 tokenId) public view returns (address) {
        return _tokenApprovals[tokenId];
    }

    function isApprovedOrOwner(address spender, uint256 tokenId)
        internal
        view
        returns (bool)
    {
        require(_exists(tokenId), "Token does not exists");
        address owner = ownerOf(tokenId);
        return (spender == owner ||
            isApprovedForAll(owner, spender) ||
            getApproved(tokenId) == spender);
    }
}
