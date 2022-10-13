// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

import "../../interfaces/IRousseauRepository.sol";
import "../base/RousseauProtocol.sol";
import "../../libraries/DataTypes.sol";
import "@openzeppelin/access/Ownable.sol";

contract RousseauRepository is IRousseauRepository, Ownable {
    address private _protocol;

    bool initialized = false;

    mapping(uint256 => uint256) public timelocks;
    mapping(uint256 => DataTypes.Comment[]) public comments;

    uint256[] public activeValues;

    error Timelocked();
    error NotInitialized();
    error NotProtocol();
    error ZeroAddressNotAllowed();

    modifier isInitialized() {
        if (!initialized) revert NotInitialized();
        _;
    }

    modifier isProtocol() {
        if (msg.sender != _protocol) revert NotProtocol();
        _;
    }

    constructor() {}

    function initialize(address protocol) external onlyOwner {
        if (protocol == address(0)) revert ZeroAddressNotAllowed();
        _protocol = protocol;
        initialized = true;
    }

    function addValue(
        uint256 proposalId,
        string calldata value,
        uint256 date,
        bytes calldata customData
    ) external isInitialized isProtocol {
        timelocks[proposalId] = dynamicBytesToUint(customData);
        activeValues.push(proposalId);
    }

    function removeValue(
        uint256 proposalId,
        uint256 data,
        uint256 date,
        bytes calldata customData
    ) external isInitialized isProtocol {
        if (timelocks[data] > block.timestamp || timelocks[data] == 1)
            revert Timelocked();
        delete timelocks[proposalId];
        unchecked {
            for (uint256 i = 0; i < activeValues.length; i++) {
                if (activeValues[i] == proposalId) {
                    activeValues[i] = activeValues[activeValues.length - 1];
                    activeValues.pop();
                    break;
                }
            }
        }
    }

    function replaceValue(
        uint256 proposalId,
        string calldata value,
        uint256 data,
        uint256 date,
        bytes calldata customData
    ) external isInitialized isProtocol {
        if (timelocks[data] > block.timestamp || timelocks[data] == 1)
            revert Timelocked();
        timelocks[proposalId] = dynamicBytesToUint(customData);
        unchecked {
            for (uint256 i = 0; i < activeValues.length; i++) {
                if (activeValues[i] == data) {
                    activeValues[i] = proposalId;
                    break;
                }
            }
        }
    }

    // 0 means no timelock, 1 means timelock is forever, otherwise the number is the block.timestamp when the timelock ends
    function canRemove(
        uint256 proposalId,
        uint256 data
    ) external isInitialized isProtocol returns (bool) {
        return timelocks[data] < block.timestamp && timelocks[data] != 1;
    }

    // 0 means no timelock, 1 means timelock is forever, otherwise the number is the block.timestamp when the timelock ends
    function canReplace(
        uint256 proposalId,
        uint256 data
    ) external isInitialized isProtocol returns (bool) {
        return timelocks[data] < block.timestamp && timelocks[data] != 1;
    }

    function addComment(
        uint256 proposalId,
        string calldata comment,
        address author
    ) external isInitialized isProtocol {
        comments[proposalId].push(
            DataTypes.Comment(comment, block.timestamp, author)
        );
    }

    function dynamicBytesToUint(bytes calldata input)
        internal
        returns (uint256)
    {
        bytes memory b = input;
        uint256 result = 0;
        for (uint256 i = 0; i < b.length; i++) {
            uint256 c = uint256(uint8(b[i]));
            if (c >= 48 && c <= 57) {
                result = result * 10 + (c - 48);
            }
        }
        return result;
    }
}
