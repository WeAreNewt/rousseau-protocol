import { AddModal } from "../components/modals/AddModal"
import { ChangeModal } from "../components/modals/ChangeModal";
import type { NextPage } from 'next'
import { useState } from 'react';

const Modals: NextPage = () => {

  const [showAdd, setShowAdd] = useState(false);
  const [showChange, setShowChange] = useState(false);

  return (
    <div className="flex flex-col items-center justify-center">
      <button
          onClick={() => setShowAdd(true)}
          className=" flex flex-row bg-gray-600 text-white rounded-full w-56 h-10 justify-center items-center mt-2 ml-auto"
          type="button"
        >
          Open add modal
        </button>
        <button
          onClick={() => setShowChange(true)}
          className=" flex flex-row bg-gray-600 text-white rounded-full w-56 h-10 justify-center items-center mt-2 ml-auto"
          type="button"
        >
          Open change modal
        </button>
        <AddModal show={showAdd} setShow={setShowAdd}/>
        <ChangeModal show={showChange} setShow={setShowChange}/>
    </div>
  )
}

export default Modals
