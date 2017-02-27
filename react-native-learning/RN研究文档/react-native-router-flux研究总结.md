#### react-native-router-flux研究总结

##### 框架集成步骤

1. 配置`package.json`依赖

   ```json
    "react": "^0.14.7",
    "react-native": "0.22.2",
    "react-native-button": "^1.2.1",
    "react-native-drawer": "^1.16.7",
    "react-native-modalbox": "^1.3.0",
    "react-native-router-flux": "file:../"
   #此处react-native-route-flux框架可以通过npm info查看
   ```

2. 配置`index.js`文件中的`Scene`，注册可以跳转的页面

   ```javascript
   #定义reducers
   const reducerCreate = params => {
     const defaultReducer = Reducer(params);
     return (state, action) => {
       console.log("ACTIONS:" ,action);
       return defaultReducer(state, action);
     }
   }

   #注册好所有可以跳转的页面和跳转用来传参的key值
   class MyExample extends React.Component {
     constructor(props) {
       super(props)
     }
     render() {
       return <Router createReducer={reducerCreate}>
         <Scene key="modal" component={Modal}>
           <Scene key="root">
               <Scene key="Launch" component={Launch} title="Launch" initial={true}/>
               <Scene key="login" component={Login} title="Login" />
           </Scene>
         </Scene>
       </Router>
     }
   }

   #此处的key=login对于下面很有用处
   ```

3. 首页和其他供跳转的页面的写法

   ```javascript
   class Launch extends React.Component {
     constructor(props) {
       super(props)
     }
     render() {
       return (
         <View {...this.props} style={styles.container}>
           <Text>这是首页！</Text>
           <Button onPress={()=>Actions.login({data:"Custom data", title:"Custom title" })}>Go to Login page</Button>
         </View>
       )
     }
   }

   #根据步骤二中的key=login来传递参数！！！
   ```