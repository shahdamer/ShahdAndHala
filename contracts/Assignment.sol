// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;
contract Voting {
  
  mapping (string => uint256) private votesReceived;
  
  string[] private candidateList;

  constructor (string[] memory candidateNames) public {
    candidateList = candidateNames;
  }

  function showCandidateList()view public returns (string[] memory){
  return candidateList;
 }

 function addCandidatePri(string memory candidate) private returns (bool){
   bool f= validCandidate(candidate);
   if(f)
   return false;
   else{
   candidateList.push(candidate);
   return true;
   }
 }
 function addCandidate(string memory candidate) public returns (string memory){
   bool f= addCandidatePri(candidate);
   if(f)
   return "he/she is already a candidate";
   else
   return "add a Candidate success";
 }

  // This function returns the total votes a candidate has received so far
  function totalVotesFor(string memory candidate) view public returns (uint256) {
    require(validCandidate(candidate),"the person you want the total votes for is not a candidate");
    return votesReceived[candidate];
  }

  function voteForCandidate(string memory candidate) public {
    require(validCandidate(candidate),"the person you want to vote for is not a candidate");
    votesReceived[candidate] += 1;
  }

  function compareStrings(string memory str1,string memory str2) private pure returns(bool){
      return keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2));
  }
  
  function validCandidate(string memory candidate) view private returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
     bool f=compareStrings(candidateList[i], candidate) ;
     if(f){
        return true;
      }
    }
    return false;
  }

  function isValidCandidate(string memory candidate) view public returns (string memory){
    bool f=validCandidate(candidate) ;
     if(f){
        return "he/she is a candidate";
      }
      else
      {
      return "he/she is not a candidate";
      }
  }

   function winningCandidate() public view returns (string memory ){
        uint winningVoteCount = 0;
        string memory winnerName=" ";
        for (uint i = 0; i< candidateList.length; i++) {
            if (votesReceived[candidateList[i]] > winningVoteCount) {
                winningVoteCount = votesReceived[candidateList[i]];
                winnerName = candidateList[i];
            }
        }
        return winnerName;
    }

}
 //["shahd","hala","ahmad"]
 
 
