import React, { useState, useEffect } from "react";
import Helmet from "../../../components/Helmet/Helmet";
import SlideBar from "../../../components/UI/slider/SlideBar";
import "../../../styles/dashboard.scss";
import "../../../styles/admin.scss";

import { Link, useNavigate, useParams } from "react-router-dom";
import { HOST } from "../../../env/config";

function History() {
    const {id} = useParams()
    const navigate = useNavigate()
    const [histories, setHistories] = useState([])
    const [user, setUser] = useState({})

    useEffect(() => {
        getUser()
        getHistories()
    }, [])

    var getUser = async () => {
        let id = sessionStorage.getItem('user')
        if (id) {
            await fetch(`${HOST}/api/user/${id}`, {
            method: 'GET',
            })
            .then((res) => res.json())
            .then((data) => {
            setUser(data)
            console.log(data);
            if (data.is_superuser !== true) {
                navigate('/error')
            }
            })
            .catch((error) => {
            console.log(error);
            navigate('/error')
            })
        }
        else {
            navigate('/error')
        }
    }
    
    var getHistories = async () => {
        await fetch(`${HOST}/api/admin/users/${id}/history`, {
            method: 'GET',
          })
          .then((res) => res.json())
          .then((data) => {
            setHistories(data)
          })
          .catch((error) => {
            console.log(error);
            navigate('/error')
          })
    }
  return (
    <Helmet title="AdminPage">
      <div className="admin__section d-flex">
        <SlideBar />
        <div className="main__content">
          <h1>Lịch sử</h1>
          <div className="d-list">
            <table className="table">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">Nội dung</th>
                  <th scope="col">Ngày </th>
                </tr>
              </thead>
              <tbody>
              {histories.map((item, index) => (
                <Tr item={item} key={item.id} index={index}/>
              ))}
              </tbody>
            </table>
          </div>
          <div className="row w-100">
            <div className="form-group form-submit">
                <Link to={"/admin"} type="button" className="btn select__action--add" >
                Quay lại
                </Link>
            </div>
        </div>
        </div>;
      </div>
    </Helmet>
  )
}

const Tr = (props) => {
    const format_date = (date) => {
      return date.substring(0, 10) + " " + date.substring(11, 16)
    }

    const slash = (value) => {
      return value ? value : '-'
    }
    const {id, _created, message} = props.item
    return (
      <tr className="d-item">
        <th scope="row">{props.index + 1}</th>
        <td>{slash(message)}</td>
        <td>{format_date(_created)}</td>  
      </tr>
    )
  }

export default History