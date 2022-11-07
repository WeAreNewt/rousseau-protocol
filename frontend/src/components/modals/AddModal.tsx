import { useState } from "react";

type AddModalProps = {
  show: boolean;
  setShow: (show: boolean) => void;
};

export const AddModal: React.FC<AddModalProps> = ({
  show,
  setShow,
}: AddModalProps) => {
  const [status, setStatus] = useState(1);

  return (
    <div
      onMouseDown={() => setShow(false)}
      className={`${
        show ? "block" : "hidden"
      } fixed h-screen w-screen z-20 flex items-center justify-center create-btn-gradient-transparent px-4 lg:px-0 top-0 left-0`}
    >
      <div
        onMouseDown={(e) => e.stopPropagation()}
        className={`${
          status ? "h-[200px]" : " h-[432px]"
        } flex flex-col items-center w-[530px] rounded-[10px]`}
        style={{ boxShadow: "0px 4px 4px rgba(0, 0, 0, 0.25)" }}
      >
        {status === 0 ? (
          // No state
          <div className="flex flex-col w-full px-5 mt-6">
            <b className="flex flex-row font-medium text-base leading-6">
              propose adding value
            </b>
            <textarea
              className="flex flex-row box-border border rounded-lg border-solid border-gray-1000 resize-none focus:outline-none text-gray-600 px-py mt-4 h-[300px] left-[23px] top-[70px] px-[10px] py-[10px]"
              defaultValue={"your proposal text here"}
            />
            <button
              onClick={() => setStatus(1)}
              className="flex flex-row bg-gray-600 text-white rounded-full w-56 h-10 justify-center items-center mt-2 ml-auto"
              type="button"
            >
              propose add
            </button>
          </div>
        ) : (
          // Success state
          <div className="flex flex-col w-full px-5 mt-6 items-center">
            <b className="flex flex-row font-medium text-base leading-6 mr-auto mt-3">
              changes reflected!
            </b>
            <p className="flex flex-row text-gray-600 top-[83px] mr-auto mt-3">
              your proposal is now live
            </p>
            <button
              onClick={() => setStatus(0)}
              className=" flex flex-row bg-gray-600 text-white rounded-full w-56 h-10 justify-center items-center mt-6"
              type="button"
            >
              go to proposal
            </button>
          </div>
        )}
      </div>
    </div>
  );
};
