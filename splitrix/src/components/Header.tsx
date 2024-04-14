import logo from '../assets/images/logo-transparent-png.png'
import '../assets/styles/Header.css'


const Header = () => {
  return (
    <>
    <div className="header_wrapper">
        <img src={logo} alt="" width="200px"/>
        <p className='profile_name'><i className="fa-solid fa-user"></i> Narendra Reddy</p>
    </div>
    </>
  )
}

export default Header