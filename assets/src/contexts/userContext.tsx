import React, { Reducer } from "react";

import { Student } from "../graphql";
import { useReducer } from "react";

export interface UserStoreInterface {
  user?: Pick<Student, "id" | "email" | "name">;
}

export type UserActions = {
  type: "SET_USER";
  payload: UserStoreInterface["user"];
};

const userContextInitialState = {};

export type UserContextType = [UserStoreInterface, React.Dispatch<UserActions>];

const userReducer: Reducer<UserStoreInterface, UserActions> = (
  state,
  action
) => {
  switch (action.type) {
    case "SET_USER":
      return { ...state, user: action.payload };
    default:
      return state;
  }
};

const Context = React.createContext<UserContextType>([
  userContextInitialState,
  () => null,
]);

export const UserContextProvider: React.FC = ({ children }) => {
  const [store, dispatch] = useReducer(userReducer, userContextInitialState);

  return (
    <Context.Provider value={[store, dispatch]}>{children}</Context.Provider>
  );
};

export function useUserContext(): UserContextType {
  return React.useContext(Context);
}
