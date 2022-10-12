// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

library DataTypes {
  enum VoteType {
    YES,
    NO,
    ABSTAIN
  }

  enum ProposalType {
    ADD,
    REMOVE,
    REPLACE
  }

  enum ProposalStatus {
    QUEUED,
    VOTING,
    COMPLETED,
    EXECUTED
  }

  struct Proposal {
    string value;
    mapping(VoteType => uint256) votes;
    ProposalType kind;
    uint256 data;
    uint256 start;
    bytes customData;
  }

  struct Comment {
    string value;
    uint256 date;
    address author;
  }

}