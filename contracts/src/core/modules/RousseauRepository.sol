// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

import "../../interfaces/IRousseauRepository.sol";
import "../base/RousseauProtocol.sol";
import "../../libraries/DataTypes.sol";
import "@openzeppelin/access/Ownable.sol";

contract RousseauRepository is IRousseauRepository, Ownable {
    address private _protocol;

    bool initialized = false;

    mapping(uint256 => uint256) private timelocks;
    mapping(uint256 => DataTypes.Comment) private comments;

    error Timelocked();
    error NotInitialized();
    error NotProtocol();

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
        _protocol = protocol;
        initialized = true;
    }

    function addValue(
        uint256 proposalId,
        string calldata value,
        uint256 data,
        uint256 date
    ) external isInitialized isProtocol {
        if (timelocks[proposalId] > block.timestamp) revert Timelocked();
        
    }

    function removeValue(
        uint256 proposalId,
        string calldata value,
        uint256 data,
        uint256 date
    ) external isInitialized isProtocol {
    }

    function replaceValue(
        uint256 proposalId,
        string calldata value,
        uint256 data,
        uint256 date
    ) external isInitialized isProtocol {
    }

    function canRemove(
        uint256 proposalId,
        uint256 kind,
        uint256 data,
        uint256 start
    ) external isInitialized isProtocol returns (bool) {
        return
            timelocks[proposalId] < block.timestamp &&
            timelocks[proposalId] != 1;
    }

    function canReplace(
        uint256 proposalId,
        uint256 kind,
        uint256 data,
        uint256 start
    ) external isInitialized isProtocol returns (bool) {
        return
            timelocks[proposalId] < block.timestamp &&
            timelocks[proposalId] != 1;
    }

    function addComment(uint256 proposalId, string calldata comment)
        external
        isInitialized
        isProtocol
    {
        comments[proposalId] = DataTypes.Comment(
            comment,
            block.timestamp,
            msg.sender
        );
    }
}
