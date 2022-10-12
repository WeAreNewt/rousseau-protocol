// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

import "../../interfaces/IRousseauRepository.sol";
import "../base/RousseauProtocol.sol";
import "../../libraries/DataTypes.sol";
import "@openzeppelin/access/Ownable.sol";

contract RousseauRepository is IRousseauRepository, Ownable {

    RousseauProtocol protocol;

    bool initialized = false;

    mapping(uint256 => uint256) private timelocks;
    mapping(uint256 => DataTypes.Comment) private comments;

    error Timelocked();
    error NotInitialized();

    modifier isInitialized() {
        if (!initialized) revert NotInitialized();
        _;
    }

    constructor() {
        initialized = true;
    }

    function addValue(
        uint256 proposalId,
        string calldata value,
        uint256 data,
        uint256 date
    ) external isInitialized {;
        //TODO: Only RousseauProtocol
    }

    function removeValue(
        uint256 proposalId,
        string calldata value,
        uint256 data,
        uint256 date
    ) external isInitialized {
        //TODO:  Only RousseauProtocol
    }

    function replaceValue(
        uint256 proposalId,
        string calldata value,
        uint256 data,
        uint256 date
    ) external isInitialized {
        //TODO: Only RousseauProtocol
    }

    // TODO: check if timelock is there
    function canRemove(
        uint256 proposalId,
        uint256 kind,
        uint256 data,
        uint256 start
    ) external isInitialized returns (bool) {
        return
            timelocks[proposalId] < block.timestamp && timelocks[proposalId] > 0;
    }

    function canReplace(
        uint256 proposalId,
        uint256 kind,
        uint256 data,
        uint256 start
    ) external isInitialized returns (bool) {
        return
            timelocks[proposalId] < block.timestamp && timelocks[proposalId] > 0;
    }

    function addComment(uint256 proposalId, string calldata comment)
        external
        isInitialized
    {
        //TODO: Only RousseauProtocol
        comments[proposalId] = DataTypes.Comment(
            comment,
            block.timestamp,
            msg.sender
        );
    }
}
