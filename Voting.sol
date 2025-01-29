// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    address public owner;
    mapping(address => bool) public voters;
    mapping(uint256 => Candidate) public candidates;
    uint256 public candidateCount;
    uint256 public totalVotes;

  
    constructor() {
        owner = msg.sender;
    }

    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    
    function addCandidate(string memory _name) public onlyOwner {
        candidateCount++;
        candidates[candidateCount] = Candidate(candidateCount, _name, 0);
    }

    
    function vote(uint256 _candidateId) public {
        require(!voters[msg.sender], "You have already voted");
        require(_candidateId > 0 && _candidateId <= candidateCount, "Invalid candidate");

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;
        totalVotes++;
    }

  
    function getWinner() public view returns (string memory) {
        uint256 winningVoteCount = 0;
        string memory winnerName;
        for (uint256 i = 1; i <= candidateCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winnerName = candidates[i].name;
            }
        }
        return winnerName;
    }
}
