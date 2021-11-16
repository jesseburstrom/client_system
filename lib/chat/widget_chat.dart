part of "../main.dart";

extension WidgetChat on Chat {

  Widget widgetChat(double width, double height) {
    Widget widgetChatOutput() {
      Widget widget = ListView.builder(
          controller: scrollController,
          itemCount: messages.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          itemBuilder: (context, index) {
            if (messages[index].messageContent.isNotEmpty) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.centerLeft
                      : Alignment.centerRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.grey.shade200
                          : Colors.blue[200]),
                    ),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    child: Text(messages[index].messageContent,
                        style: const TextStyle(fontSize: 14)),
                  ),
                ),
              );
            } else {
              return const Text("", style: TextStyle(fontSize: 20));
            }
          });

      return widget;
    }

    Widget widget = Container(
        width: width,
        height: height,
        color: Colors.blue.shade100.withOpacity(0.2),
        child: Stack(children: [
          SizedBox(height: height - 30, child: widgetChatOutput()),
          Positioned(
              top: height - 30,
              child: SizedBox(
                  width: width,
                  height: 30,
                  child: widgetInputText(sendMessage_, onSubmitted,
                      chatTextController, focusNode)))
        ]));
    return widget;
  }
}
