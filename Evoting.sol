// pragma solidity >0.4.99<0.6
pragma solidity ^0.5.10;
contract Election {
     constructor (string memory _name) public {
        owner = msg.sender;
        electionName = _name;
    }
    struct Candidate {
        string  name;
        uint voteCount;
    }
    
    struct Voter {
        bool authorized;
        bool voted;
        uint vote;
    }
    
    address public owner;
    string public electionName;
    
    mapping(address => Voter) public voters;
    Candidate[] public candidates;
    uint public totalVotes;
    
    modifier ownerOnly() {
        require(msg.sender == owner);
        _;
    }
    
   
    
    function addCanditate(string memory _name) ownerOnly public {
    candidates.push(Candidate(_name, 0)); }
    
   
    function getNumCandidate() public view returns(uint) {
        return candidates.length;
    }
    
    function  authorize(address _person) ownerOnly public {
        voters[_person].authorized = true;
    }

    function  vote(uint256 _voteIndex) public {
        require(!voters[msg.sender].voted);
        require(voters[msg.sender].authorized);
        
        voters[msg.sender].vote = _voteIndex;
        voters[msg.sender].voted = true;
        
        candidates[_voteIndex].voteCount +=1;
        totalVotes +=1;
    }

     function end() ownerOnly public {
     selfdestruct(msg.sender); 
         
    
     }
}
