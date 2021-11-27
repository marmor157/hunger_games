import { Dispatch, SetStateAction, useState } from "react";

export const useForm = <T, K extends keyof T>(
  initialValues: T
): [T, (value: T[K], key: K) => void, Dispatch<SetStateAction<T>>] => {
  const [values, setValues] = useState(initialValues);

  return [
    values,
    (value, key) => {
      setValues({
        ...values,
        [key]: value,
      });
    },
    setValues,
  ];
};

export default useForm;
