// SPDX-License-Identifieer: MIT
pragma solidity ^0.8.0;

import "./interfaces/IERC165.sol";

// Setting up an interface support for all the ERC standard contracts to follow along with
contract ERC165 is IERC165 {

    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor() {
      _registerInterface(bytes4(keccak256('supportsInterface(bytes4)')));
    }

    function supportsInterface(bytes4 interfaceID)
        external
        view
        override
        returns (bool)
    {
        return _supportedInterfaces[interfaceID];
    }

    function _registerInterface(bytes4 interfaceId) internal {
        require(
            interfaceId != 0xffffffff,
            "Invalid interface requires: interfaceId cannot be 0xffffffff"
        );
        _supportedInterfaces[interfaceId] = true;
    }
}
