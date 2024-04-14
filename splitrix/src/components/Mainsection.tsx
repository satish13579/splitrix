import DataTable from 'react-data-table-component';
import React, { useState } from 'react';
import Creategroup from './Creategroup';

const Mainsection = () => {
    const [showData,setShowData] = useState('recent_transactions');

    const activeClass = (str: string) => {
        if(str === 'recent_transactions'){
            document.getElementById('create_new_group')?.classList.remove('active');
            document.getElementById(str)?.classList.add('active');
            document.getElementById('groups')?.classList.remove('active');
            document.getElementById('notifications')?.classList.remove('active');
            setShowData('recent_transactions')
        }
        else if(str === 'groups'){
            document.getElementById('create_new_group')?.classList.remove('active');
            document.getElementById(str)?.classList.add('active');
            document.getElementById('recent_transactions')?.classList.remove('active');
            document.getElementById('notifications')?.classList.remove('active');
            setShowData('groups')
        }
        else if(str === 'notifications'){
            document.getElementById('create_new_group')?.classList.remove('active');
            document.getElementById(str)?.classList.add('active');
            document.getElementById('groups')?.classList.remove('active');
            document.getElementById('recent_transactions')?.classList.remove('active');
            setShowData('notifications')
        }
        else if(str === 'create_new_group'){
            document.getElementById('recent_transactions')?.classList.remove('active');
            document.getElementById(str)?.classList.add('active');
            document.getElementById('groups')?.classList.remove('active');
            document.getElementById('notifications')?.classList.remove('active');
            setShowData('create_new_group')
        }
        else{
            console.log(str)
            setShowData('recent_transactions')
    }
    }

    const transactionColumns = [
        {
          name: 'ID',
          selector: (row: { id: any; }) => row.id,
          sortable: true,
        },
        {
          name: 'Full Name',
          selector: (row: { fullName: any; }) => row.fullName,
        },
        {
          name: 'Email',
          selector: (row: { email: any; }) => row.email,
        },
      ];

      const groupColumns = [
        {
          name: 'ID',
          selector: (row: { id: any; }) => row.id,
          sortable: true,
        },
        {
          name: 'Full Name',
          selector: (row: { fullName: any; }) => row.fullName,
        },
        {
          name: 'Email',
          selector: (row: { email: any; }) => row.email,
        },
      ];
      
      const transactionData = [
        { id: 1, fullName: 'John Doe', email: 'john.doe@example.com' },
        { id: 2, fullName: 'Jane Smith', email: 'jane.smith@example.com' },
        { id: 3, fullName: 'Peter Parker', email: 'peter.parker@example.com' },
      ];

      const groupData = [
        { id: 1, fullName: 'John Doe', email: 'john.doe@example.com' },
        { id: 2, fullName: 'Jane Smith', email: 'jane.smith@example.com' },
        { id: 3, fullName: 'Peter Parker', email: 'peter.parker@example.com' },
      ];

  return (
    <>
    <div className="main_section">
        <div className="main_section_wrapper">
            <div className="recent_transactions active" id="recent_transactions" onClick={() => activeClass('recent_transactions')}>
                <i className="fa-solid fa-clock-rotate-left fa-xl" ></i>
                <p>Recent Transactions</p>
            </div>
            <div className="groups" id="groups" onClick={() => activeClass('groups')}>
                <i className="fa-solid fa-users fa-xl" ></i>
                <p>Group (active)</p>
            </div>
            <div className="notifications" id="notifications" onClick={() => activeClass('notifications')}>
                <i className="fa-solid fa-bell fa-xl"  ></i>
                <p>Notifications</p>
            </div>
            <div className="create_new_group" id="create_new_group" onClick={() => activeClass('create_new_group')}>
                <i className="fa-solid fa-plus fa-xl" ></i>
                <p>Create Group</p>
            </div>
        </div>
        <div className="main_section_data">
          {  showData === "recent_transactions" ? <DataTable columns={transactionColumns} data={transactionData} selectableRows pagination highlightOnHover className='transaction_table'/> : <span></span>}
          {showData === "groups" ? <DataTable columns={groupColumns} data={groupData} selectableRows pagination highlightOnHover className='transaction_table'/> : <span></span>}
          {showData === "notifications" ? <span>not working</span> : <span></span>}
          {showData === "create_new_group" ? <Creategroup /> : <span></span>}
        </div>
    </div>
    </>
  )
}

export default Mainsection