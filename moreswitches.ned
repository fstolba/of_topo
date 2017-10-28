//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
//

import inet.node.ethernet.Eth100M;
import inet.linklayer.ieee80211.mac.ratecontrol.OnoeRateControl;
import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.inet.StandardHost;
import openflow.nodes.*;



network moreswitches
{
    @display("bgb=583,320");
    submodules:
        sw1: Open_Flow_Switch {
            @display("p=171,100");
        }
        sw4: Open_Flow_Switch {
            @display("p=327,100");
        }
        sw3: Open_Flow_Switch {
            @display("p=320,236");
        }
        sw2: Open_Flow_Switch {
            @display("p=171,242");
        }
        n1: StandardHost {
            @display("p=50,116");
        }
        n2: StandardHost {
            @display("p=498,116");
        }
        configurator: IPv4NetworkConfigurator {
            parameters:
                @display("p=527,236");
           // interfaceTableModule = default(absPath(".interfaceTable"));        
        }
        ctrl: Open_Flow_Controller {
            @display("p=255,166");
        }
    connections:
        sw1.ethg++ <--> Eth100M <--> sw4.ethg++;
        sw1.ethg++ <--> Eth100M <--> sw2.ethg++;
        sw4.ethg++ <--> Eth100M <--> sw3.ethg++;
        sw3.ethg++ <--> Eth100M <--> sw2.ethg++;
        n1.ethg++ <--> Eth100M <--> sw1.ethg++;
        sw4.ethg++ <--> Eth100M <--> n2.ethg++;
        ctrl.ethg++ <--> Eth100M <--> sw1.gate_controller++;
        ctrl.ethg++ <--> Eth100M <--> sw4.gate_controller++;
        ctrl.ethg++ <--> Eth100M <--> sw2.gate_controller++;
        ctrl.ethg++ <--> Eth100M <--> sw3.gate_controller++;
}
