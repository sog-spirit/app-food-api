import Layout from "./components/Layout/Layout";
import {CartProvider, UserProvider} from './context';
function App() {
  return (
    <UserProvider>
      <CartProvider>
        <Layout />
      </CartProvider>
    </UserProvider>
  );
}

export default App;
