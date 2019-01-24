## test-ospf-summary

### Summary:

This repo is to test how to do OSPF type-5 route summarization on the ASBR

### Network Diagram:

![Network Diagram](https://github.com/Cloudofyou/test-ospf-summary/blob/master/documentation/test-ospf-summary.png)

### Initializing the demo environment:

First, make sure that the following is currently running on your machine:

1. Vagrant > version 2.1.2

    https://www.vagrantup.com/

2. Virtualbox > version 5.2.16

    https://www.virtualbox.org

3. Copy the Git repo to your local machine:

    ```git clone https://github.com/Cloudofyou/test-ospf-summary```

4. Change directories to the following

    ```test-ospf-summary```

6. Run the following:

    ```./gititup.sh```

### Running the Ansible Playbook

1. SSH into the oob-mgmt-server:

    ```cd vx-simulation```   
    ```vagrant ssh oob-mgmt-server```

2. Copy the Git repo unto the oob-mgmt-server:

    ```git clone https://github.com/Cloudofyou/test-ospf-summary```

3. Change directories to the following

    ```test-ospf-summary/automation```

4. Run the following:

    ```./confignet.sh```

This will bring run the automation script and configure the three switches with OSPF.

Switch <b>r3</b> has 4 static routes representing external networks that need to be injected into OSPF via redistribution. In order to accomplish this, we created another static aggregate route of the 4 downstream networks (in this case, 172.18.0.0/22).

We create a route-map to only allow the summary route 172.18.0.0/22 into the OSPF network which shows from <b>r1</b> with a ```net show route```.

### Errata

1. To shutdown the demo, run the following command from the vx-simulation directory:

    ```vagrant destroy -f```

2. This topology was configured using the Cumulus Topology Converter found at the following URL:

    https://github.com/CumulusNetworks/topology_converter

3. The following command was used to run the Topology Converter within the vx-simulation directory:

    ```python2 topology_converter.py int-ansible-training-clag-nclu.dot -c```

    After the above command is executed, the following configuration changes are necessary:

4. Within ```vx-simulation/helper_scripts/auto_mgmt_network/OOB_Server_Config_auto_mgmt.sh```

The following stanza:

    #Install Automation Tools
    puppet=0
    ansible=1
    ansible_version=2.3.1.0

Will be replaced with the following:

    #Install Automation Tools
    puppet=0
    ansible=1
    ansible_version=2.6.2

The following stanza will replace the install_ansible function:

```
install_ansible(){
echo " ### Installing Ansible... ###"
apt-get install -qy ansible sshpass libssh-dev python-dev libssl-dev libffi-dev
sudo pip install pip --upgrade
sudo pip install setuptools --upgrade
sudo pip install ansible==$ansible_version --upgrade
}```

Add the following ```echo``` right before the end of the file.

    echo " ### Adding .bash_profile to auto login as cumulus user"
    echo "sudo su - cumulus" >> /home/vagrant/.bash_profile
    echo "exit" >> /home/vagrant/.bash_profile

    echo "############################################"
    echo "      DONE!"
    echo "############################################"
