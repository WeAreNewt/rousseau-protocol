// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

contract AvaraProtocol {

    event ProposalCreated();
    event ProposalDeleted();
    event ProposalUpdated();

    enum VoteType {
        YES,
        NO,
        ABSTAIN
    }

    struct Proposal {
        string value;
        mapping(VoteType => uint256) votes;
        uint256 start;
    }

    mapping(uint256 => Proposal) private _proposals;

    uint256 _counter = 0;

    function _createProposal(string calldata value) internal {
        Proposal storage newProposal = _proposals[++_counter];
        newProposal.value = value;
        newProposal.start = block.timestamp;
    }

    function _deleteProposal(uint256 proposalId) internal {
        delete _proposals[proposalId];
    }

}
