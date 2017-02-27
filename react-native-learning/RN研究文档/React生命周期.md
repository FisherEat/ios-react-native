#### React组件生命周期

##### 组件的生命周期

组件的生命周期分为三个状态

```javascript
1. Mounting: 已插入真实的 DOM
2. Updating: 正在被重新渲染
3. Unmounting: 已移出真实 DOM
```

React为每种状态提供了两种处理函数，`will`函数在进入状态之前调用，`did`函数在进入状态之后调用，三种状态共计五种处理函数：

```javascript
1. componentWillMount()
2. componentDidMount()
3. componentWillUpdate(object nextProps, object nextState)
4. componentDidUpdate(object prevProps, object prevState)
5. componentWillUnmount()
```

此外，React还提供两种特殊状态的处理函数： 

```javascript
1. componentWillReceiveProps(object nextProps)：已加载组件收到新的参数时调用
2. shouldComponentUpdate(object nextProps, object nextState)：组件判断是否重新渲染时调用
```

