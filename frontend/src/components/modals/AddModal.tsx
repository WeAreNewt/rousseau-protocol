export const AddModal: React.FC = () => {
  return (
    <div className="rounded-lg shadow-2xl items-center justify-center border-gray-1000 border">
      <p>
        propose adding value
      </p>
      <textarea className="box-border rounded-lg border-solid border-gray-1000 border w-{480} h-{432} left-6 top-16 absolute resize focus:outline-none text-gray-600">your proposal text here</textarea>
      <button
        className="justify-center items-center bg-gray-600 text-white rounded-full w-56 h-10 mt-4"
        type="button"
      >
        propose change
      </button>
    </div>
  );
};
