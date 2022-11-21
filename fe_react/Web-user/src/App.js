import DashBoard from "./components/Layout/DashBoard";
import Layout from "./components/Layout/Layout";
import { CartProvider, UserProvider } from './context';
import { store } from './store/store'
function App() {
  return (
    <UserProvider>
      <CartProvider>
        {/* is user  */}
        <Layout />
        {/* is admin */}
        {/* <DashBoard /> */}
      </CartProvider>
    </UserProvider>
  );
}

export default App;
