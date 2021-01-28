pragma solidity ^0.5.0;

contract Decentragram {
  string public name = "Decentragram";

  //Store posts/images
  uint public imageCount = 0;
  mapping(uint => Image) public images;

  struct Image {
    uint id;
    string hash;
    string description;
    uint tipAmount;
    address payable author;
  }

  event ImageCreated(
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address payable author
  );

  event ImageTipped(
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address payable author
  );

  //Create posts/images
  function uploadImage(string memory _imgHash, string memory _description) public {
    //Make sure that the image description is not blank
    require(bytes(_description).length > 0);
    //Make sure that there is an image
    require(bytes(_imgHash).length > 0);
    //Make sure uploader address exists
    require(msg.sender != address(0x0));
    //Increment Image ID
    imageCount ++;
    //Add Image to the contract
    images[imageCount] = Image(imageCount, _imgHash, _description, 0, msg.sender);
    //Trigger an event saying an image has been added
    emit ImageCreated(imageCount, _imgHash, _description, 0, msg.sender);
  }

  //Tip posts/images
  function tipImageOwner(uint _id) public payable {
    require (_id > 0 && _id <= imageCount);
    //Fetch Image
    Image memory _image = images[_id];
    //Fetch the author
    address payable _author = _image.author;
    //Pay the author
    address(_author).transfer(msg.value);
    //Increment the tip amount
    _image.tipAmount = _image.tipAmount + msg.value;
    //Update the image
    images[_id] = _image;
    //Triugger an event
    emit ImageTipped(_id, _image.hash, _image.description, _image.tipAmount, _author);
  }
}