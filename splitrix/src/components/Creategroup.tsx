import React from 'react'
import '../assets/styles/Home.css'


const Creategroup = () => {
  return (
    <span style={{width : '100%',margin : 'auto'}}>
        <div className="create_group">
            <div className="group_name">
                <label htmlFor="">
                    <b>Group Name :</b>    
                </label>
                <input type="text" name="" id="" />
            </div>
            <div className="amount">
                <label htmlFor="">
                    <b>Amount :</b>
                </label>
                <input type="number" />
            </div>
            <div className="group_members">
                <label htmlFor=""><b>Members :</b></label>
                <select name="" id="">
                    <option value="">Select Members</option>
                    <option value="satish chandra">Satish Chandra</option>
                    <option value="sujan bannu">Sujan Bannu</option>
                    <option value="sandeep varma">Sandeep Varma</option>
                </select>
            </div>
            <div className="three_buttons">
                <button>Reset <i className="fa-solid fa-retweet"></i></button>
                <button>Cancel <i className="fa-solid fa-xmark"></i></button>
                <button>Create <i className="fa-regular fa-circle-check"></i></button>
            </div>
        </div>    
    </span>
  )
}

export default Creategroup