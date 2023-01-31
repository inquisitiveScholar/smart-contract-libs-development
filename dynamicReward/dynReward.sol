
pragma solidity ^0.8.0; 

//SPDX-License-Identifier: MIT

contract DynamicReward {


uint totalRewardEligible; // no of people who eligible to get reward

uint rewardIndex;

uint rewardAmount; // it will hold reward until reward will close 
    
struct  rewardStruct {

    uint rewardShare; // total amount of share that will distribute between reward eligible  users/peoples 
    uint rewardCollectionTillCurrent; // reward all collection till current index

}

mapping(uint =>rewardStruct) public Rewards;


function addNewReward(uint amount) public {

   rewardAmount+=amount;

}


function addRewardEligibleUser() public{

    totalRewardEligible++;
}


function closeReward() public {

    rewardStruct memory _reward=Rewards[rewardIndex];
    require(rewardAmount>0,"you don't have any fund to close reward");
    require(totalRewardEligible>0,"you don't have any eligible user to close reward");

    _reward.rewardCollectionTillCurrent+=rewardAmount;
    _reward.rewardShare+= (rewardAmount/totalRewardEligible);

    rewardIndex++;
    Rewards[rewardIndex] = _reward;
    delete rewardAmount;

}

//-----------------------------view function -------------------

function getCurrentIndex() view public returns(uint){

    return rewardIndex;
}

function getTotalRewardEligbleUser() view public returns (uint ){

    return totalRewardEligible;
}


function getPotentialReward(uint _positionIndex) view public returns (uint){

    uint potReward;

    require(rewardIndex>=_positionIndex,"invalid index");

    potReward= Rewards[rewardIndex].rewardShare-Rewards[_positionIndex].rewardShare;

    return potReward;
}


function getRewardStats(uint _index) view public returns(uint _rewardShare , uint _rewardTotalCollection){

    _rewardShare = Rewards[_index].rewardShare; 
    _rewardTotalCollection = Rewards[_index].rewardCollectionTillCurrent;
}



}

