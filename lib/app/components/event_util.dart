import 'package:event_bus/event_bus.dart';
EventBus eventBus = new EventBus();
 
class VideoEvent{
  int pause;
  VideoEvent(this.pause);
 
}