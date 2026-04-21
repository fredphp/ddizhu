<%@ WebHandler Language="C#" Class="Q.WebSocketHandler" %>

using System;
using System.Web;
using System.Linq;
using System.Data;
using System.Threading;
using System.Net.WebSockets;
using System.Web.WebSockets;
using System.Threading.Tasks;

namespace Q {
  public class WebSocketHandler:IHttpHandler {
    public void ProcessRequest(HttpContext context) {
      if(context.IsWebSocketRequest) {
        context.AcceptWebSocketRequest(WebSocketRequestHandler);
      }
    }

    public bool IsReusable => false;

    //Asynchronous request handler. 
    public async Task WebSocketRequestHandler(AspNetWebSocketContext webSocketContext) {
      //Gets the current WebSocket object. 
      WebSocket webSocket = webSocketContext.WebSocket;

      /*We define a certain constant which will represent 
      size of received data. It is established by us and  
      we can set any value. We know that in this case the size of the sent 
      data is very small. 
      */
      const int maxMessageSize = 1024;

      //Buffer for received bits. 
      var receivedDataBuffer = new ArraySegment<Byte>(new Byte[maxMessageSize]);

      var cancellationToken = new CancellationToken();

      //Checks WebSocket state. 
      while(webSocket.State == WebSocketState.Open) {
        //Reads data. 
        var webSocketReceiveResult = await webSocket.ReceiveAsync(receivedDataBuffer,cancellationToken);

        //If input frame is cancelation frame, send close command. 
        if(webSocketReceiveResult.MessageType == WebSocketMessageType.Close) {
          await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure,String.Empty,cancellationToken);
        } else {
          var payloadData = receivedDataBuffer.Array.Where(b => b != 0).ToArray();

          //Because we know that is a string, we convert it. 
          var receiveString = System.Text.Encoding.UTF8.GetString(payloadData,0,payloadData.Length);

          //Converts string to byte array. 
          var newString = String.Format("Hello, " + receiveString + " ! Time {0}",DateTime.Now.ToString());
          var bytes = System.Text.Encoding.UTF8.GetBytes(newString);

          //Sends data back. 
          await webSocket.SendAsync(new ArraySegment<byte>(bytes),WebSocketMessageType.Text,true,cancellationToken);
        }
      }
    }
  }
}