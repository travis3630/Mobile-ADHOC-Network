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

package manet;

import inet.common.scenario.ScenarioManager;
import inet.environment.common.PhysicalEnvironment;
import inet.mobility.single.Ns2MotionMobility;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.dymo.DymoRouter;
//import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.common.geometry.common.SimpleGeographicCoordinateSystem;

import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
//import inet.physicallayer.unitdisk.UnitDiskRadioMedium;
//package inet.examples.mobility; #ns2mobility
//import inet.environment.common.PhysicalEnvironment; //wall
import inet.visualizer.integrated.IntegratedCanvasVisualizer; //visualizer

//
// TODO
//
network manet
{
    parameters:
        int numHosts;
        @figure[title](type=label; pos=0,-1; anchor=sw; color=darkblue);
        @signal[host2_rcvdPk];
        @delegatesignal[rcvdPk](source=hostB.app[0].rcvdPk; target=hostB_rcvdPk);
        @statistic[receptionPower](source="receptionMinSignalPower(radioMedium.signalArrivalStarted)"; record=last, vector);
        @statistic[endToEndDelay](title="end-to-end delay"; source="dataAge(packetReceived)"; unit=s; record=histogram,weightedHistogram,vector; interpolationmode=none);
        @display("bgb=3890.505,2192.0625");
    submodules:
        //        radioMedium: UnitDiskRadioMedium {
        //            parameters:
        //                @display("p=272.58,306.6525");
        //        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                config = xml("<config><interface hosts='*' address='145.236.x.x' netmask='255.255.0.0'/></config>");
                @display("p=277.4475,603.57");
        }
//        routingTableRecorder: RoutingTableRecorder {
//            parameters:
//                @display("p=277.4475,77.88");
//        }
        scenarioManager: ScenarioManager {
            parameters:
                script = default(xml("<scenario/>"));
                @display("p=277.4475,924.825");
        }
        host[numHosts]: DymoRouter {
            parameters:
                @display("i=device/pocketpc_s;r=,,#707070;p=1825.3125,876.14996");
        }

        visualizer: IntegratedCanvasVisualizer {
            @display("p=277.4475,1119.525");
        }

        physicalEnvironment: PhysicalEnvironment {
            @display("p=277.4475,1377.5024");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=277.4475,360.195");
        }
    //        ns2MotionMobility: Ns2MotionMobility {
    //            @display("p=160,119");
    //        }
    connections allowunconnected:
}
