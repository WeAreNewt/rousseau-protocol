export const ChangeModal: React.FC = () => {
  return (
    <div
      className="flex flex-col items-center w-[530px] h-[432px] rounded-[10px]"
      style={{ boxShadow: "0px 4px 4px rgba(0, 0, 0, 0.25)" }}
    >
      <button
        className="flex flex-row justify-center items-center bg-gray-600 text-white rounded-full w-56 h-10 mt-4"
        type="button"
      >
        propose removal
      </button>
      <div className="mt-5 mb-5">
        <div className="flex flex-row items-center">
          <svg
            width="216"
            height="1"
            viewBox="0 0 216 1"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
            className="flex flex-col mr-4"
          >
            <line y1="0.5" x2="215.142" y2="0.5" stroke="#838383" />
          </svg>
          or
          <svg
            width="216"
            height="1"
            viewBox="0 0 216 1"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
            className="flex flex-col ml-4"
          >
            <line y1="0.5" x2="215.142" y2="0.5" stroke="#838383" />
          </svg>
        </div>
      </div>
      <div className="flex flex-col w-full px-5">
        <p className="flex flex-row font-medium text-base leading-6">
          propose change
        </p>
        <textarea className="flex flex-row box-border border rounded-lg border-solid border-gray-1000 resize-none focus:outline-none text-gray-600 px-py mt-4 h-[200px] left-[23px] top-[186px] px-[10px] py-[10px]">
          your proposal text here
        </textarea>
        <button
          className=" flex flex-row bg-gray-600 text-white rounded-full w-56 h-10 justify-center items-center mt-2 ml-auto"
          type="button"
        >
          propose change
        </button>
      </div>
    </div>
  );
};
