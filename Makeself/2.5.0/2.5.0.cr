class Target < ISM::Software
    
    def prepareInstallation
        super

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin")

        moveFile("#{mainWorkDirectoryPath(false)}/makeself.sh","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin/makeself")
    end

    def install
        super

        runChmodCommand(["+x","/usr/bin/makeself"])
    end

end
